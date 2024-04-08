use axum::{
    response::{IntoResponse, Response},
    http::header::HeaderValue,
    body::Body,
};
use std::{convert::Infallible, fs::File, io::Read};
use docx_rs::*;

pub async fn handler() -> Result<impl IntoResponse, Infallible> {
    let path = std::path::Path::new("./reglamento_interno.docx");
    let mut file = match File::create(path) {
        Ok(file) => file,
        Err(_) => return Ok(Response::new(Body::empty())),
    };
    let header =
        Paragraph::new().add_run(Run::new().add_text("Reglamento interno"));

    let first_header =
        Paragraph::new().add_run(Run::new().add_text("Sobre la cooperativa"));
    
    let chapter_paragraph=
        Paragraph::new().add_run(Run::new().add_text("Algo sobre la cooperativa"));


    let new_document_result = Docx::new()
        .add_paragraph(header)
        .add_paragraph(first_header)
        .add_paragraph(chapter_paragraph)
        .build()
        .pack(&mut file);

    if new_document_result.is_err() {
         return Err(GenerateDocumentError); 
    }

    let mut file = match File::open(path) {
        Ok(file) => file,
        Err(_) => return Ok(Response::new(Body::empty())),
    };
    let mut contents = Vec::new();
    if let Err(_) = file.read_to_end(&mut contents) {
        return Ok(Response::new(Body::empty()));
    }

    let mut response = Response::new(Body::from(contents));
    response.headers_mut().insert(
        axum::http::header::CONTENT_TYPE,
        HeaderValue::from_static("application/vnd.openxmlformats-officedocument.wordprocessingml.document"),
    );

    Ok(response)
}

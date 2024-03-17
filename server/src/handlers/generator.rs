use axum::{
    response::{IntoResponse, Response},
    http::header::HeaderValue,
    body::Body,
};
use std::{convert::Infallible, fs::File, io::Read};
use docx_rs::*;

pub async fn handler() -> Result<impl IntoResponse, Infallible> {
    let path = std::path::Path::new("./hello.docx");
    let mut file = match File::create(path) {
        Ok(file) => file,
        Err(_) => return Ok(Response::new(Body::empty())),
    };

    if let Err(_) = Docx::new()
        .add_paragraph(Paragraph::new().add_run(Run::new().add_text("Hello")))
        .build()
        .pack(&mut file)
    {
        return Ok(Response::new(Body::empty()));
    };

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

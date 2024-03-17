use docx_rs::*;
use axum::response::{Html, IntoResponse};
pub async fn handler() -> impl IntoResponse {
    let path = std::path::Path::new("./hello.docx");
    let file = std::fs::File::create(path).unwrap();
    Docx::new()
        .add_paragraph(Paragraph::new().add_run(Run::new().add_text("Hello")))
        .build()
        .pack(file)?;
    Ok(());
    Html(file).into_response()
}
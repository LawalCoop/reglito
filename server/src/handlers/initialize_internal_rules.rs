use axum::extract::Form;
use axum::response::{Html, IntoResponse};
use serde::Deserialize;

#[derive(Debug, Deserialize)]
pub struct FormData {
    name: String,
    matricule: String,
}

pub async fn handler(Form(data): Form<FormData>) -> impl IntoResponse {
    let greeting = format!("Welcome, {}! matricule: {}", data.name, data.matricule);
    Html(greeting).into_response()
}

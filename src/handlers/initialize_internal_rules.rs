use axum::extract::Form;
use serde::Deserialize;
use axum::{
    response::{Html, IntoResponse},
};

#[derive(Debug, Deserialize)]

pub struct FormData {
    name: String,
    matricule: String,
}

pub async fn handler(Form(data): Form<FormData>) -> impl IntoResponse {
    let greeting = format!("Welcome, {}!", data.name);
    Html(greeting).into_response()
}
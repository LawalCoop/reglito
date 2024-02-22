use askama::Template;
mod handlers;
use serde::Deserialize;
#[derive(Template)]
#[template(path = "index.html")]
struct HelloTemplate {}

use axum::{
    http::{Response, StatusCode},
    response::{Html, IntoResponse},
    routing::{get, post},
    Router,
};
use axum::extract::Form;
use tower_livereload::LiveReloadLayer;

#[derive(Debug, Deserialize)]
struct FormData {
    name: String,
    matricule: String,
}

async fn hello() -> impl IntoResponse {
    let template = HelloTemplate {};
    match template.render() {
        Ok(html) => Html(html).into_response(),
        Err(err) => (
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("Failed to render template. Error: {err}"),
        )
        .into_response(),
    }
}

async fn initialize_rules_form(Form(data): Form<FormData>) -> impl IntoResponse {
    let greeting = format!("Welcome, {}!", data.name);
    Html(greeting).into_response()
}

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(hello))
        .route("/initialize", post(initialize_rules_form))
        .layer(LiveReloadLayer::new());

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8005").await.unwrap();

    axum::serve(listener, app).await.unwrap();
}

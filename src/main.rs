use askama::Template;
mod handlers;

#[derive(Template)]
#[template(path = "index.html")]
struct HelloTemplate {}

use axum::{
    http::StatusCode,
    response::{Html, IntoResponse},
    routing::get,
    Router,
};
use tower_livereload::LiveReloadLayer;

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

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(hello))
        .layer(LiveReloadLayer::new());

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8005").await.unwrap();

    axum::serve(listener, app).await.unwrap();
}

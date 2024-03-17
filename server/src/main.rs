mod handlers;

use crate::handlers::{index, initialize_internal_rules, select_chapters, generator};
use axum::{
    routing::{get, post},
    Router,
};
use tower_livereload::LiveReloadLayer;

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(index::handler))
        .route("/select_chapters", get(select_chapters::handler))
        .route("/generate_text", get(generator::handler))
        .route("/initialize", post(initialize_internal_rules::handler))
        .layer(LiveReloadLayer::new());

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8005").await.unwrap();

    axum::serve(listener, app).await.unwrap();
}

use askama::Template;
mod handlers;
use entity::internal_rules::Entity as InternalRules;
use handlers::initialize_internal_rules;
use migration::{Migrator, MigratorTrait};
use sea_orm::EntityTrait;
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

#[tokio::main]
async fn main() {
    let connection = sea_orm::Database::connect("sqlite::memory:").await.unwrap();
    Migrator::up(&connection, None).await.unwrap();
    let results = InternalRules::find().all(&connection).await;

    print!("RESULTS {:#?}", results);

    let app = Router::new()
        .route("/", get(hello))
        .route("/initialize", post(initialize_internal_rules::handler))
        .layer(LiveReloadLayer::new());

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8005").await.unwrap();

    axum::serve(listener, app).await.unwrap();
}

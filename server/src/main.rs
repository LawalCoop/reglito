use askama::Template;
mod handlers;
use axum::{
    http::StatusCode,
    response::{Html, IntoResponse},
    routing::{get, post},
    Router,
};
use entity::internal_rules::Entity as InternalRules;
use handlers::initialize_internal_rules;
use migration::{Migrator, MigratorTrait};
use sea_orm::EntityTrait;
use serde::{Deserialize, Serialize};
use tower_livereload::LiveReloadLayer;

#[derive(Serialize, Deserialize)]
struct Chapter {
    pub title: String,
    pub options: Option<Vec<Chapter>>,
}

#[derive(Template, Serialize, Deserialize)]
#[template(path = "index.html")]
struct HelloTemplate {
    pub chapters: Vec<Chapter>,
}

async fn hello() -> impl IntoResponse {
    let template = HelloTemplate {
        chapters: vec![Chapter {
            title: "Capitulo 1".to_string(),
            options: None,
        }],
    };
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

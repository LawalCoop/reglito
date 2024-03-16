mod handlers;

use crate::handlers::{index, initialize_internal_rules, select_chapters};
use axum::{
    routing::{get, post},
    Router,
};
use entity::chapter::Entity as Chapter;
use migration::{Migrator, MigratorTrait};
use sea_orm::EntityTrait;
use tower_livereload::LiveReloadLayer;

#[tokio::main]
async fn main() {
    let connection = sea_orm::Database::connect("sqlite::memory:").await.unwrap();
    Migrator::up(&connection, None).await.unwrap();
    let results = Chapter::find().all(&connection).await;

    print!("RESULTS {:#?}", results);

    let app = Router::new()
        .route("/", get(index::handler))
        .route("/select_chapters", get(select_chapters::handler))
        .route("/initialize", post(initialize_internal_rules::handler))
        .layer(LiveReloadLayer::new());

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8005").await.unwrap();

    axum::serve(listener, app).await.unwrap();
}

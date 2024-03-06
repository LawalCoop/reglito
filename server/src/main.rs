mod handlers;
use axum::{
    routing::{get, post},
    Router,
};

use handlers::{index, initialize_internal_rules, select_chapters};
use tower_livereload::LiveReloadLayer;

/*
--- DATABASE EXAMPLE IMPORTS ---

use entity::internal_rules::Entity as InternalRules;
use migration::{Migrator, MigratorTrait};
use sea_orm::EntityTrait;

--- DATABASE EXAMPLE IMPORTS ---
*/

#[tokio::main]
async fn main() {
    /*
    --- USE DATABASE EXAMPLE ----

    let connection = sea_orm::Database::connect("sqlite::memory:").await.unwrap();
    Migrator::up(&connection, None).await.unwrap();
    let results = InternalRules::find().all(&connection).await;

    print!("RESULTS {:#?}", results);

    --- USE DATABASE EXAMPLE ----
     */

    let app = Router::new()
        .route("/", get(index::handler))
        .route("/select_chapters", get(select_chapters::handler))
        .route("/initialize", post(initialize_internal_rules::handler))
        .layer(LiveReloadLayer::new());

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8005").await.unwrap();

    axum::serve(listener, app).await.unwrap();
}

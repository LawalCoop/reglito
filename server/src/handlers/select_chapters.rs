use askama::Template;
use axum::{
    http::StatusCode,
    response::{Html, IntoResponse},
};
use entity::chapter::Entity as ChapterEntity;
use entity::chapter::Model as Chapter;
use migration::{Migrator, MigratorTrait};
use sea_orm::EntityTrait;
use serde::{Deserialize, Serialize};

#[derive(Template, Serialize, Deserialize)]
#[template(path = "select_chapters.html")]
struct SelectChaptersTemplate {
    pub chapters: Vec<Chapter>,
}

pub async fn handler() -> impl IntoResponse {
    let connection = sea_orm::Database::connect("sqlite::memory:").await.unwrap();
    Migrator::up(&connection, None).await.unwrap();
    let results = ChapterEntity::find().all(&connection).await;

    let chapters: Vec<Chapter> = results.unwrap();

    let template = SelectChaptersTemplate { chapters };

    match template.render() {
        Ok(html) => Html(html).into_response(),
        Err(err) => (
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("Failed to render template. Error: {err}"),
        )
            .into_response(),
    }
}

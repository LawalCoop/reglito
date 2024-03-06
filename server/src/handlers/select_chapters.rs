use askama::Template;
use axum::{
    http::StatusCode,
    response::{Html, IntoResponse},
};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
struct Chapter {
    pub title: String,
    pub options: Option<Vec<Chapter>>,
}

#[derive(Template, Serialize, Deserialize)]
#[template(path = "select_chapters.html")]
struct SelectChaptersTemplate {
    pub chapters: Vec<Chapter>,
}

pub async fn handler() -> impl IntoResponse {
    let template = SelectChaptersTemplate {
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

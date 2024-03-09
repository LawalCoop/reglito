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
    let opt1_chap1 = Chapter {
        title: "Articulo 1".to_string(),
        options: None,
    };

    let chap1 = Chapter {
        title: "Capitulo 1".to_string(),
        options: Some(vec![opt1_chap1]),
    };

    let opt1_chap2 = Chapter {
        title: "Articulo 1".to_string(),
        options: None,
    };
    let opt2_chap2 = Chapter {
        title: "Articulo 2".to_string(),
        options: None,
    };

    let chap2 = Chapter {
        title: "Capitulo 2".to_string(),
        options: Some(vec![opt1_chap2, opt2_chap2]),
    };

    let opt1_chap3 = Chapter {
        title: "Articulo 1".to_string(),
        options: None,
    };

    let chap3 = Chapter {
        title: "Capitulo 3".to_string(),
        options: Some(vec![opt1_chap3]),
    };

    let template = SelectChaptersTemplate {
        chapters: vec![chap1, chap2, chap3],
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

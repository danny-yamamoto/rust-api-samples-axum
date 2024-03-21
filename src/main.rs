use axum::{routing::get, Error, Json, Router};
use serde::Serialize;
use tokio_postgres::NoTls;

#[derive(Serialize)]
pub struct User {
    pub user_id: i32,
}

async fn users_fetch_data() -> Result<Vec<User>, Error> {
    let (client, connection) = tokio_postgres::connect("host=db user=postgres password=postgres port=5432 dbname=postgres", NoTls).await.unwrap();
    tokio::spawn(async move {
        if let Err(e) = connection.await {
            eprint!("Failed to connect: {}", e);
        }
    });
    let rows = client.query("select * from users", &[]).await.unwrap();
    let mut data = Vec::new();
    for row in &rows {
        let user_id_to_row = row.get("user_id");
        let user_data = User { user_id: user_id_to_row };
        data.push(user_data);
    }
    Ok(data)
}

#[tokio::main]
async fn main() {
    let app = Router::new().route("/", get(|| async {
        let data = users_fetch_data().await.unwrap_or_else(|e| {
            eprint!("Failed to fetch: {}", e);
            Vec::new()
        });
        Json(data)
    }));
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}

# 使用するベースイメージを指定します。Rustの公式イメージを使用します。
#FROM rust:latest as builder
FROM public.ecr.aws/docker/library/rust:latest as builder

# 作業ディレクトリを設定します。
WORKDIR /usr/src/rust-api-samples-axum

# 依存関係をキャッシュするために、Cargo.toml と Cargo.lock をコピーします。
# ただし、Cargo.lock がない場合はスキップしてください。
COPY Cargo.toml ./

# ダミーのソースファイルを作成して、依存関係だけをビルドします。
# これにより、ソースコードの変更がない限り、依存関係の再コンパイルを避けられます。
RUN mkdir src/ && \
    echo "fn main() {println!(\"if you see this, the build broke\")}" > src/main.rs
RUN cargo build --release

RUN ls -la /usr/src/rust-api-samples-axum

RUN ls -la target/release/

# 本物のソースコードをコピーします。
COPY ./src ./src

# ダミーのソースファイルを削除して、本物のソースファイルでアプリケーションを再ビルドします。
RUN touch src/main.rs && \
    cargo build --release && \
    # バイナリを一時的な場所にコピーします。
    cp target/release/rust-api-samples-axum /usr/src/rust-api-samples-axum/rust-api-samples-axum

# 実行ステージを設定します。ビルドステージでコンパイルしたバイナリを軽量なイメージにコピーします。
#FROM debian:12
FROM public.ecr.aws/debian/debian:12

# SSL証明書をインストールします。これは、外部APIとの安全な通信に必要な場合があります。
RUN apt-get update && apt-get install -y libssl-dev ca-certificates && rm -rf /var/lib/apt/lists/*

# ビルドステージからバイナリをコピーします。
COPY --from=builder /usr/src/rust-api-samples-axum/rust-api-samples-axum .

EXPOSE 80

# アプリケーションを実行します。
CMD ["./rust-api-samples-axum"]

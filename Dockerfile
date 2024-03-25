# Rust用のDockerイメージをベースにします
FROM rust:latest AS builder

# 作業ディレクトリを設定します
WORKDIR /usr/src/myapp

# Rust依存関連ファイルをコピーします
COPY Cargo.toml Cargo.lock ./
COPY src ./src

# 依存関係をビルドします（キャッシュを利用するために、バイナリのみをビルド）
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/usr/src/myapp/target \
    cargo build --release

# 実行可能なバイナリを取得します
RUN mv target/release/myapp /usr/local/bin/myapp

# 実行用の軽量なDockerイメージをベースにします
FROM debian:buster-slim

# 依存関係をインストールします
RUN apt-get update && apt-get install -y libpq-dev

# 実行可能なバイナリをコピーします
COPY --from=builder /usr/local/bin/myapp /usr/local/bin/myapp

# ポート3000を公開します（アプリケーションのポートに合わせて変更可能）
EXPOSE 80

# アプリケーションを実行します
CMD ["myapp"]

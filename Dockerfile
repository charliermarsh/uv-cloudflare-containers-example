# Use a Python image with uv pre-installed.
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

# Install the project into `/app`.
WORKDIR /app

# Enable bytecode compilation.
ENV UV_COMPILE_BYTECODE=1

# Copy from the cache instead of linking since it's a mounted volume.
ENV UV_LINK_MODE=copy

# Copy the project's configuration files.
ADD ./app/pyproject.toml /app
ADD ./app/uv.lock /app

# Install the project's dependencies.
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-install-workspace --no-dev

# Copy the project into the image.
ADD ./app /app

# Sync the project.
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

# Place executables in the environment at the front of the path.
ENV PATH="/app/.venv/bin:$PATH"

# Reset the entrypoint, don't invoke `uv`.
ENTRYPOINT []

# Run the FastAPI server.
EXPOSE 8080
CMD ["uvicorn", "main:app", "--host", "10.0.0.1", "--port", "8080"]

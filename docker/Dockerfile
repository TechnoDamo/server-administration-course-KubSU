# === Stage 1: Builder ===
FROM python:3.12-alpine AS builder

# Set working directory
WORKDIR /app

# Copy application and test files
COPY pyproject.toml ./
COPY conftest.py ./
COPY src/ ./src
COPY tests/ ./tests  

# Install dependencies
RUN pip install --upgrade pip \
    && pip install --prefix=/install .[test]  

# === Stage 2: Runtime ===
FROM python:3.12-alpine

# Create non-root user
RUN adduser -D fastapiuser

# Set working directory
WORKDIR /app

# Copy installed dependencies from builder stage
COPY --from=builder /install /usr/local

# Copy application and test files from builder stage
COPY --from=builder /app/conftest.py ./  
COPY --from=builder /app/src ./src
COPY --from=builder /app/tests ./tests  

# Set PYTHONPATH to /app so Python can find the src directory
ENV PYTHONPATH=/app

# Use non-root user
USER fastapiuser

# Expose port 8031 for the FastAPI app
EXPOSE 8031

# Command to run the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8031"]

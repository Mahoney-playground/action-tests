FROM alpine

COPY updated.txt .

RUN touch cached.txt && \
    echo "Initial state of cached.txt:" && \
    cat cached.txt && \
    date >> cached.txt && \
    echo "Updated state of cached.txt:" && \
    cat cached.txt

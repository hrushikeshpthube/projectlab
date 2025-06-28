# Stage 1: Build
FROM node:18-alpine AS builder

WORKDIR /app

# Copy only the app directory content
COPY app/package*.json ./
RUN npm install --only=production

COPY app .

# Stage 2: Run
FROM node:18-alpine

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app
COPY --from=builder /app ./

# Set ownership to non-root user
RUN chown -R appuser:appgroup /app

USER appuser
EXPOSE 3000
CMD ["node", "app.js"]


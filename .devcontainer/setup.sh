#!/bin/bash
set -e

echo "🚀 Setting up development environment..."

# Copy env file if not exists
if [ ! -f .env ]; then
  cp .env.example .env
  echo "✅ Created .env from .env.example"
fi

# Install dependencies
echo "📦 Installing npm dependencies..."
npm install

# Start infrastructure
echo "🐳 Starting Docker services..."
docker compose -f infrastructure/docker/docker-compose.dev.yml up -d

# Wait for PostgreSQL
echo "⏳ Waiting for PostgreSQL..."
until docker compose -f infrastructure/docker/docker-compose.dev.yml exec -T postgres pg_isready -U synhaptix 2>/dev/null; do
  sleep 2
done
echo "✅ PostgreSQL ready"

# Sync database schema
echo "🗄️ Syncing Prisma schema..."
npx prisma db push

# Install Playwright browsers
echo "🎭 Installing Playwright browsers..."
npx playwright install chromium --with-deps

echo ""
echo "✅ Setup complete!"
echo "   Run 'npm run dev' to start the API on :3000"
echo "   Run 'cd frontend && npm run dev' to start the UI on :5173"

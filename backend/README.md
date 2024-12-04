# Restaurant Menu Backend

A Django-based backend service for managing restaurant menus with support for PDF processing, full-text search, and version control.

## Prerequisites

- Python 3.8+
- MySQL 8.0+
- OpenAI API key
- Virtual environment (recommended)

## Setup

1. **Clone the repository and navigate to backend directory**

```
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. **Install dependencies**

```
pip install -r requirements.txt
```

4. **Configure environment variables**

Create a `.env` file in the backend directory:
```
DB_NAME=restaurantdb
DB_USER=root
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=3306
OPENAI_API_KEY=your_openai_api_key
```

5. **Setup database**

```
# Create MySQL database
mysql -u root -p
CREATE DATABASE restaurantdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
exit

# Run migrations
python manage.py migrate

# Create fulltext indexes
mysql -u root -p restaurantdb < fts.sql
```

## Running the Server

```
python manage.py runserver
```
The server will start at `http://localhost:8000`

## Available Management Commands

- **Create test data**

```
python manage.py create_test_data
```

- **Process menu from PDF/HTML**

```
python manage.py process --file path/to/menu.pdf
```

## API Endpoints

- `GET /api/restaurants/` - List all restaurants
- `GET /api/restaurants/<id>/full_details` - Get restaurant details

## Project Structure

```
backend/
├── core/               # Django project settings
├── menu/              # Main app
│   ├── management/    # Custom management commands
│   ├── migrations/    # Database migrations
│   └── models.py      # Data models
│   └── views.py       # API endpoints
├── media/             # Uploaded files
└── manage.py          # Django CLI
```

## Development Notes

- The backend uses MySQL full-text search for efficient menu item lookups
- Menu versions are tracked with timestamps and version numbers
- PDF processing is handled via OpenAI's GPT-4o API
- All database operations use transactions for data integrity

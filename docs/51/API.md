# API (Draft)

Base URL: `http://localhost:8080`

## Health
GET `/api/health`
- 200: `{ "status": "ok" }`

## Recommendations
GET `/api/recommendations/{menu_item_id}`
- Path: `menu_item_id` (string or numeric)
- 200: `{ "item_id": "123", "related": [ {"id": "x", "score": 0.87} ] }`

## Stock Optimization
GET `/api/stock_optimization`
- Query: `horizon_days` (optional, default 7)
- 200: `{ "ingredients": [ {"name": "tomato", "priority": 0.91} ] }`

## Trending Recipes
GET `/api/trending_recipes`
- 200: `[ { "id": 1, "name": "Dalgona Coffee", "popularity_score": 9.5 } ]`

## Notes
- Authentication TBD (token/JWT)
- Pagination and filtering to be added as lists grow
- Error format: `{ "error": { "code": "...", "message": "..." } }`

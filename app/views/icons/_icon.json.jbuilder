json.extract! icon, :id, :name, :image, :created_at, :updated_at
json.url icon_url(icon, format: :json)
json.image url_for(icon.image)

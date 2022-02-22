class IconResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  field :name, as: :text
  field :image, as: :file, is_image: true

  field :direct_phonetics, as: :has_many, through: :icon_phonetics
  field :undirect_phonetics, as: :has_many, through: :icon_phonetics
end

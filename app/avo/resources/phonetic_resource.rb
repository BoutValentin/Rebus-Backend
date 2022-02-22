class PhoneticResource < Avo::BaseResource
  self.title = :phonetic
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  field :phonetic, as: :text
  field :syllable_letter, as: :has_many 
  
  field :direct_phonetic_icons, as: :has_many, through: :icon_phonetics
  field :undirect_phonetic_icons, as: :has_many, through: :icon_phonetics
end

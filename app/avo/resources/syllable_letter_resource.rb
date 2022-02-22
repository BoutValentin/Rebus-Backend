class SyllableLetterResource < Avo::BaseResource
  self.title = :syllable_letter
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # add fields here
  field :syllable_letter, as: :text
  field :phonetic, as: :belongs_to, nullable: true, required: false

  filter AsPhoneticFilter
end

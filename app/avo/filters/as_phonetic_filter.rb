class AsPhoneticFilter < Avo::Filters::SelectFilter
  self.name = 'As phonetic filter'

  def apply(request, query, value)
    case value
    when 'as_phonetic'
      query.where.not(phonetic_id: nil)
    when 'as_not_phonetic'
      query.where(phonetic_id: nil)
    else
      query
    end
  end

  def options
    {
      'as_phonetic': "As phonetic",
      'as_not_phonetic': "As not phonetic attach"
    }
  end
end

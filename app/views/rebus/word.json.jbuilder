json.id @rebus.id
json.difficulty @rebus.difficulty
json.rebus @final_syllable do |re|
    if re.is_a? String
        json.name re
        json.id nil
        json.image_url nil
    elsif re.is_a? Array
        json.array! re do |ree|
            if ree.is_a? String
                json.name ree
                json.id nil
                json.image_url nil
            else
                json.id ree.id
                json.name ree.name
                json.image_url url_for(ree.image)
            end
        end
    else 
        json.id re.id
        json.name re.name
        json.image_url url_for(re.image)
    end
end

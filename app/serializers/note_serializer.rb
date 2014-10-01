class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :updated_at
end

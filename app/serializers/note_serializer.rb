class NoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at
end

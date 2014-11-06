module ApiHelpers
  def json(clear=false)
    @json = nil if clear
    @json ||= JSON.parse(response.body)
  end
end

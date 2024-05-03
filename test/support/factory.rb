# frozen_string_literal: true

module Factory
  module_function

  def generate_project(**input)
    Wip::Projects::Create
      .call(**{ name: "My wonderful project",
                description: "Lorem ipsum dolor sit amet",
                project_type: "service" }.merge(input))
      .value!
  end

  def generate_note(**input)
    Wip::Notes::Create
      .call(**{ title: "My wonderful note",
                content: "Lorem ipsum dolor sit amet",
                tags: "note" }.merge(input))
      .value!
  end
end

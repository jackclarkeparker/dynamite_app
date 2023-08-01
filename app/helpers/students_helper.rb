module StudentsHelper
  def try_display_primary_contact_relation(student)
    relation = student.primary_contact_relation
    if relation && relation.length > 0
      ' (' + student.primary_contact_relation + ')'
    end
  end

  def primary_contact_field(student)
    if student.primary_contact
      link_to(student.primary_contact) + content_tag(
        :span,
        try_display_primary_contact_relation(student),
        class: "primary-contact-relation"
      )
    else
      'N/A'
    end
  end
end

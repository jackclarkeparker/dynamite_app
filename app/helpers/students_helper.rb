module StudentsHelper
  def try_display_relation(student_contact)
    relation = student_contact.contact_relation
    " (#{relation})" if relation && relation.length > 0
  end

  def primary_contact_field(student)
    primary_student_contact = student.student_contacts.find(&:primary_contact)
    if primary_student_contact
      link_to(primary_student_contact.contact) + content_tag(
        :span,
        try_display_relation(primary_student_contact),
        class: "primary-contact-relation"
      )
    else
      'N/A'
    end
  end

  def link_to_contact_of_student_contact(student_contact)
    link_to(student_contact.contact, contact_path(student_contact.contact))
  end
end

module StudentsHelper
  def try_display_primary_contact_relation(student)
    relation = student.primary_contact_relation
    if relation && relation.length > 0
      ' (' + student.primary_contact_relation + ')' 
    end
  end
end

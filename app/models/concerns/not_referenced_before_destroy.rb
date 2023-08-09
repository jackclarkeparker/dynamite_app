module NotReferencedBeforeDestroy
  extend ActiveSupport::Concern

  included do
    before_destroy :ensure_not_referenced
  end

  private

    def ensure_not_referenced
      references = []

      non_join_table_associations.each do |association|
        if send(association.name).any?
          references << " - has associated #{association.name.to_s.pluralize}."
        end
      end

      unless references.empty?
        message = <<~MSG
          Rejected destruction of #{self.class.name.downcase} '#{self}' because it:
          #{references.join("\n")}
        MSG

        errors.add(:base, message)
        throw :abort
      end
    end

    def non_join_table_associations
      all_associations = self.class.reflect_on_all_associations(:has_many)
      
      all_associations.reject do |association|
        all_associations.any? { |a| a.options[:through] == association.name }
      end
    end
end
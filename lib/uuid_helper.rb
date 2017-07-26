module UUIDHelper
  def self.included(base)
    base.class_eval do
      before_create :set_uuid

      def set_uuid
        self.uuid ||= SecureRandom.uuid
      end
      alias_method :ensure_uuid, :set_uuid
    end
  end
end

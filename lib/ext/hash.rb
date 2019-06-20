# frozen_string_literal: true

# Import assert_valid_keys from Rails if not already defined
class Hash
  def assert_valid_keys(*valid_keys)
    valid_keys.flatten!

    each_key do |k|
      next if valid_keys.include?(k)

      raise(
        ArgumentError,
        "Unknown key: #{k.inspect}. Valid keys are: #{valid_keys.map(&:inspect).join(', ')}"
      )
    end
  end
end

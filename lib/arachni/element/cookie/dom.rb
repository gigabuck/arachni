=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    Please see the LICENSE file at the root directory of the project.
=end

module Arachni::Element
class Cookie

# Provides access to DOM operations for {Cookie cookies}.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>
class DOM < Base
    include Capabilities::Auditable::DOM

    def initialize( options )
        super

        self.inputs     = (options[:inputs] || self.parent.inputs).dup
        @default_inputs = self.inputs.dup.freeze
    end

    # Submits the cookie using the configured {#inputs}.
    def trigger
        browser.goto action, take_snapshot: false, cookies: self.inputs,
                     update_transitions: false
    end

    def name
        inputs.keys.first
    end

    def value
        inputs.values.first
    end

    def to_set_cookie
        p = parent.dup
        p.inputs = inputs
        p.to_set_cookie
    end

    def encode( *args )
        Cookie.encode( *args )
    end

    def decode( *args )
        Cookie.decode( *args )
    end

    def type
        self.class.type
    end
    def self.type
        :cookie_dom
    end

    def initialization_options
        super.merge( inputs: inputs.dup )
    end

end

end
end
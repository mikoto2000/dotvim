{{_lang_util_:package}}

import java.lang.Throwable;

/**
 * {{_name_}}
 */
public class {{_expr_:substitute('{{_name_}}', '\w\+', '\u\0', '')}} extends Exception {
    /**
     * Constructor
     */
    public {{_name_}}() {
        super();
    }

    /**
     * Constructor
     */
    public {{_name_}}(String message) {
        super(message);
    }

    /**
     * Constructor
     */
    public {{_name_}}(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Constructor
     */
    public {{_name_}}(Throwable cause) {
        super(cause);
    }
}


//
// EDC JWT Auth Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package org.eclipse.tractusx.edc.auth;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class CompositeAuthenticationServiceTest {

    @BeforeEach
    public void initialize() {
    }

    @Test
    public void testEmpty() {
        CompositeAuthenticationService service=new CompositeAuthenticationService.Builder().build();
        assertTrue(service.isAuthenticated(Map.of()),"Could authenticate against empy composite service");
    }
}

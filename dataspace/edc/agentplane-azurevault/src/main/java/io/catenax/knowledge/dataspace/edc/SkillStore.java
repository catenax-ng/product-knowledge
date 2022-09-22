//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * An in-memory store for local skills
 */
public class SkillStore {

    // temporary local skill store
    final protected Map<String,String> skills=new HashMap<>();

    public static Pattern SKILL_PATTERN=Pattern.compile("((?<url>[^#]+)#)?(?<skill>(urn:(cx|artifact):)?([Ss])kill:.*)");

    /**
     * create the store
     */
    public SkillStore() {
    }

    /**
     * match a given asset
     * @param key asset name
     * @return matcher
     */
    public Matcher matchSkill(String key) {
        return SKILL_PATTERN.matcher(key);
    }

    /**
     * check a given asset for being a skill
     * @param key asset name
     * @return whether the asset encodes a skill
     */
    public boolean isSkill(String key) {
        return matchSkill(key).matches();
    }

    /**
     * register a skill
     * @param key asset name
     * @param skill skill text
     * @return old skill text, if one was registered
     */
    public String put(String key, String skill) {
        return skills.put(key,skill);
    }

    /**
     * return the stored skill text
     * @param key asset name
     * @return optional skill text if registered
     */
    public Optional<String> get(String key) {
        if(!skills.containsKey(key)) {
            return Optional.empty();
        } else {
            return Optional.of(skills.get(key));
        }
    }
}

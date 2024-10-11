let context = #{};

let prefix_prompt = "Project Prefix:";
if ANSWERS.prefix_prompt != () {
    prefix_prompt = ANSWERS.prefix_prompt;
}

let suffix_prompt = "Project Suffix:";
if ANSWERS.suffix_prompt != () {
    suffix_prompt = ANSWERS.suffix_prompt;
}

context += prompt(prefix_prompt, "project-prefix", #{
    placeholder: "Cart",
    help: "Project Name",
    cases: [
        CasedIdentityCasedValue(PROGRAMMING_CASES),
    ],
});

if ANSWERS.suffix_options != () {
    suffix_prompt = ANSWERS.suffix_prompt;
    context += prompt(suffix_prompt, "project-suffix"", #{
        defaults_with: ANSWERS.suffix_default,
        type: Select(ANSWERS.suffix_options),
        help: "Project Suffix",
        cases: [
            CasedIdentityCasedValue(PROGRAMMING_CASES),
        ],
    });
} else {
    context += prompt(suffix_prompt, "project-suffix", #{
        defaults_with: ANSWERS.suffix_default,
        help: "Project Suffix",
        cases: [
            CasedIdentityCasedValue(PROGRAMMING_CASES),
        ],
    });
}

context += set("project-name", render("{{project-prefix}}-{{project-suffix}}", context), #{
    cases: [
        CasedIdentityCasedValue(PROGRAMMING_CASES),
        FixedKeyCasedValue("ProjectTitle", TitleCase),
    ],
});

// Return Context
context
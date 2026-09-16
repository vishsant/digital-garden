---
title: "AI Capabilities and Limitations"
date: 2026-09-12
lastmod: 2026-09-12
draft: false
tags: ["ai", "ai-safety", "frameworks", "learning"]
summary: "Course notes on the capabilities, limitations, and failure modes of generative AI."
status: "evergreen"
type: "note"
source: "https://academy.claude.com/courses/ai-capabilities-and-limitations"
---

# AI Capabilities and Limitations

> A practical mental model for understanding what generative AI can and cannot reliably do.

**Source:** [Claude Academy — AI Capabilities and Limitations](https://academy.claude.com/courses/ai-capabilities-and-limitations)  
**Type:** Course  
**Status:** Completed

## Core model

Generative AI is shaped by four properties:

1. **Next-token prediction** — how AI generates responses one token or fragment at a time.
2. **Knowledge** — what the model learned from training data, and why it can be confidently wrong.
3. **Working memory** — what the model can attend to within the current context window.
4. **Steerability** — how reliably instructions control the model’s output.

Each property exists on a continuum from capability to limitation. Real-world failures often occur when two properties meet.

The course complements *AI Fluency: Framework & Foundations*:

- **Delegation, Description, Discernment, and Diligence** are human competencies.
- This course explains the machine properties those competencies respond to.

## What AI means in this course

AI is a broad term that includes recommendation engines, spam filters, fraud detection, and routing systems. These systems sort, rank, classify, or predict, but they are not generative.

**Generative AI** produces new text, images, code, audio, or video. A useful high-level picture is pre-training followed by one or more post-training stages. Exact pipelines vary and may include supervised examples, preference optimization, safety training, synthetic data, and tool training.

- **Pre-training:** learning patterns and internal representations from large datasets.
- **Post-training / fine-tuning:** shaping behavior to be safer, more helpful, and broadly useful.

The goal is **calibrated trust**—neither blanket trust nor blanket distrust.

## How AI gets its character

### Pre-training

During pre-training, the model repeatedly learns to predict what comes next given everything written so far. The result is a document completer, not an assistant.

For example, when given “What is the capital of France?”, a raw model might continue a quiz pattern rather than answer the user directly.

### Fine-tuning

Fine-tuning uses curated examples, reward signals, and human preferences to turn the document completer into an assistant. It also shapes the assistant’s personality, defaults, and refusals.

Because fine-tuning reflects judgments about desirable behavior, those judgments leave fingerprints on the model.

### Fine-tuning fingerprints

| Behavior | Possible cause | Risk |
|---|---|---|
| **Sycophancy** | Preference for agreeable responses | Validates incorrect ideas or backs down too easily |
| **Verbosity** | Rewarding thorough answers | Gives essays when concise bullets would be better |
| **Over-caution** | Conservative safety training | Adds excessive caveats or refuses safe requests |
| **Loose confidence calibration** | Difficulty training reliable confidence | Stated certainty may not match actual accuracy |

These tendencies vary by model and fine-tuning approach.

> “The assistant you talked to wasn't born helpful. That behavior was built layer by layer, and sometimes the seams show.”

## Next-token prediction

Generative AI predicts what comes next, one token or fragment at a time. It is closer to sophisticated autocomplete than to a search engine.

The same mechanism produces both:

- Fluent, coherent writing.
- Fabricated facts, citations, dates, names, and URLs.

### Capability–limitation continuum

- **Well-worn paths:** summarizing, reformatting, explaining common concepts, and writing in familiar styles. Patterns are dense and consistent.
- **Thin paths:** niche topics, obscure people, novel combinations, and precise references. Patterns are sparse, so the model may remain fluent while becoming unreliable.

> “Smoothness and correctness are independent variables.”

A confident tone does not establish accuracy. Specific claims deserve special verification, especially:

- Names
- Dates
- Statistics
- Citations
- Quotes
- URLs

### Mitigation strategies

- Use citations and source grounding.
- Use uncertainty signaling cautiously.
- Constrain generation where possible.
- Use skills or structured formats to narrow the generation space.
- Apply generator–verifier loops with an external checking source.

The model cannot reliably distinguish grounded information from invented information on its own; verification remains the user’s responsibility.

## Working memory

The **context window** is the finite input-and-output budget for a request. It can contain current instructions, conversation history, uploaded documents, tool results, and prior responses. The model can use only the context supplied or made available for that request.

When the context exceeds its limit, behavior depends on the product or API: the request may fail, or the application may truncate, summarize, or compact history. Between sessions, context normally does not carry over unless a product feature such as memory or a `CLAUDE.md` file deliberately persists information.

### Capability–limitation continuum

- **Capability zone:** Relevant documents, constraints, and conversation fit comfortably in the current session.
- **Limitation zone:** Documents become long, conversations continue, or the user expects recall from previous sessions.

Working memory differs from the other properties because it often has a **cliff**: quality may remain stable until the window is full, then degrade suddenly without a clear warning.

### Context strengths and limits

- Short style guides, glossaries, examples, and constraints can produce immediate in-session adaptation without retraining.
- More relevant context usually produces more specific output.
- Attention is not perfectly uniform across a long input. The **lost-in-the-middle effect** means material buried in the middle may receive less attention than material near the beginning or end.

### Context degradation

More context does not always produce better results. As context grows, important material can receive less attention.

The **serial position effect** describes a U-shaped recall pattern:

- **Primacy:** Items at the beginning receive more rehearsal and are recalled well.
- **Recency:** Items at the end remain fresh and are recalled well.
- **Middle:** Items receive neither advantage and are more easily missed.

Some models and tasks show a similar pattern. Liu et al.’s controlled multi-document question-answering and key-value retrieval experiments found higher performance when relevant information appeared near the beginning or end, with degradation in the middle. This evidence is task- and model-specific; it does not establish a universal attention law or a fixed dead zone for every current model.

### Context-engineering rules

- Put important instructions at the beginning and end of the context.
- State critical constraints early in the system prompt and repeat them near the end.
- Curate context instead of including everything.
- Remove material that does not help the task; every addition can push other information toward the attention dead zone.

> More context ≠ better results. Curate ruthlessly, place strategically, and repeat what matters.

### Features that extend or soften the window

- **Memory:** Carries selected facts across sessions.
- **Compaction or summarization:** Condenses conversation history to free space.
- **Projects and workspaces:** Keep standing documents available.
- **Skills:** Load task-specific instructions only when needed.
- **Multi-agent workflows:** Give specialized agents separate context windows.
- **Larger context windows:** Push the limit further out but do not remove the edge.

### Warning signs

- Quality slips during a very long conversation.
- Details from the middle of a long document disappear from responses.
- The model is expected to recall a previous session without memory enabled.

### Practical strategies

- Lead with the most important information.
- Put critical material near the beginning of long documents.
- Chunk large work into multiple passes.
- Use projects, memory, and skills where appropriate.
- If quality degrades, start a fresh conversation with a concise summary.
- Restate critical context when necessary.

Working memory makes **Description** effective: instructions, constraints, and examples must fit inside the active window to influence the output.

## Knowledge

AI models learn from large collections of data, including internet content, public datasets, and other written sources. Through training objectives that include prediction, they build internal representations of concepts, relationships, and facts. In a model without retrieval or tools, this learned knowledge is the main source of factual recall.

They do not have human experiences or real-time web access unless a product explicitly provides a search tool. A model family also has a stated **knowledge cutoff**, but the date varies by model and later information may enter through post-training or supplied context. Information after the cutoff is therefore less reliable from parametric knowledge, not necessarily impossible to provide.

### Knowledge continuum

- **Capability zone:** Mainstream science, popular programming languages, well-documented history, and topics represented frequently and consistently before the cutoff.
- **Limitation zone:** Rare, niche, local, less-represented-language, recent, or post-cutoff topics.

The key question is not simply “Does the AI know this?” but:

> “How well-represented was this in what it read?”

### Strengths

- Broad general knowledge.
- Deep competence in well-represented domains.
- Ability to connect concepts across fields through internal representations and embeddings.

### Characteristic limitations

- **Knowledge cutoff:** Information after the stated cutoff is less reliable from parametric knowledge, though it may be supplied through tools, retrieval, or context.
- **Staleness:** Previously true information may have changed.
- **Uneven coverage:** Rare topics, minority languages, niche domains, and recent developments receive weaker representation.
- **Inherited bias:** Training-data blind spots influence assumptions about what is normal or standard.
- **Source amnesia:** The model generally cannot identify where a piece of knowledge came from; “I read this somewhere” is not a citation.

### Runtime extensions

- **Web search:** Retrieves current information and works around the cutoff.
- **MCPs and retrieval:** Connect the model to documents and specialized databases it was not trained on.
- **Tools:** Provide real-time calculators, databases, and other external capabilities.
- **Cutoff disclosure:** Helps users identify when information requires checking.

### Protection strategies

- Verify time-sensitive claims.
- Assume information may be out of date.
- Test the model in a new domain before trusting it.
- Do not assume competence transfers from one domain to a neighboring one.
- Watch for default assumptions inherited from training data.
- Use search, retrieval, and tools when available.

Knowledge directly affects:

- **Delegation:** Decide whether the model knows the domain or whether you must supply documents, context, or search.
- **Discernment:** Give extra scrutiny to recent, rare, local, or niche claims.

> The model’s knowledge is broad, deep, frozen, and imperfect at the same time.

## Steerability

**Steerability** is the model’s ability to follow directions. It can often apply roles, tones, formats, word limits, schemas, and rules on the first try.

Fine-tuning teaches the pre-trained document completer to treat user text as a request, break tasks into steps, and follow assistant instructions. However, steerability is not the same as understanding. The model still uses pattern completion, so a gap can remain between the words written and the intent behind them.

### Capability–limitation continuum

- **Capability zone:** Short, concrete, verifiable instructions such as “respond as a table,” “under 100 words,” or “use this exact schema.”
- **Limitation zone:** Long reasoning chains, abstract directions such as “be insightful,” and instructions where a small early error can compound.

A model may follow an instruction literally while missing its purpose. For example, a “punchy” summary may remove an important qualification while satisfying the word limit and tone.

### Strengths

- Tight control over format and style.
- Role and persona specification.
- Multi-step task execution.
- Iterative refinement through short, concrete revisions.

### Failure modes

- **Reasoning drift:** Small errors compound through a long chain.
- **Letter over spirit:** The stated instruction is obeyed but the real goal is missed.
- **Prompt injection:** Untrusted instructions embedded in a document or web page influence the model’s behavior, especially in tool-using systems. This is an adversarial security risk, not merely a prompt-quality problem.

### Practical strategies

- State the goal alongside the steps or format.
- Break long chains into checkpoints.
- Verify intermediate results before continuing.
- If an instruction lands literally but uselessly, restate the goal instead of repeating the instruction more forcefully.
- Keep concrete, verifiable instructions close to the task.
- Use system prompts, custom instructions, structured outputs, JSON schemas, and function calling to narrow ambiguity—but do not treat format validation as proof of semantic correctness.
- Treat retrieved or embedded content as untrusted when appropriate; use least-privilege tools, validate tool calls and outputs, and require confirmation for consequential actions. Prompting alone cannot guarantee prevention of prompt injection.

In the 4D framework, steerability is both what **Description** exploits and the constraint it operates within. Better descriptions narrow the gap between words and intent. Tasks requiring long reasoning chains or native numeric precision may need tighter human checkpoints or a different tool.

> The model often follows clear directions, but following a direction does not guarantee understanding or correctness. Your job is to make sure “following you” and “doing what you actually need” point in the same direction.

## Diagnosing AI failures

The four properties—next-token prediction, knowledge, working memory, and steerability—interact. Many real-world surprises are compound failures involving two properties; this is a useful diagnostic heuristic, not a universal empirical law.

### Diagnostic method

Before changing the prompt, ask which properties are being tested:

1. Identify the unexpected output.
2. Name the relevant property or combination of properties.
3. Locate the task on each capability–limitation continuum.
4. Apply a targeted fix instead of retrying generically.

A knowledge problem and a working-memory problem can look similar but require different responses. Naming the properties turns vague dissatisfaction into strategic iteration.

### Common compound failures

- **Next-token prediction + knowledge gap:** The model generates plausible citation-shaped text about a niche topic, but the paper does not exist.
  - Fix: Verify specifics independently or use source grounding and retrieval.
- **Working memory + steerability:** Early constraints fade or receive less attention during a long conversation, while recent instructions take over.
  - Fix: Resupply critical context, or start a fresh conversation with the essentials near the beginning.
- **Working memory + knowledge limits:** A long document contains material the model cannot keep attending to or lacks the knowledge to interpret.
  - Fix: Chunk the document, foreground key material, and supply supporting context.
- **Steerability + next-token prediction:** A vague or abstract request lets the model produce a plausible but misaligned continuation.
  - Fix: State the goal, use concrete constraints, and add checkpoints.

Diagnosis is **Discernment** in action. Repeated compound failures also inform **Delegation**: restructure, split, or retain task types that consistently exceed the model’s reliable zone.

## Key takeaways from diagnosis

- Real-world failures usually involve two interacting properties.
- Common diagnostic pairs include:
  - **Next-token prediction + knowledge:** hallucinated specifics.
  - **Working memory + steerability:** long-conversation drift.
- Naming the properties points toward the fix: verify specifics, resupply context, offload work to code execution, or invite pushback.
- This diagnostic move is **Discernment** applied: evaluate better by identifying what kind of wrong you are seeing.

## Exercises

### The Failure Diagnosis

Identify two or three AI outputs that genuinely disappointed or surprised you. For each, record what you asked, what you received, and what was unexpected.

For each event:

1. Ask the AI which of the four properties—next-token prediction, knowledge, working memory, and steerability—were involved and why.
2. Evaluate its diagnosis against your own understanding. Push back if it seems wrong; account for possible sycophancy.
3. Ask for the most targeted fix and, where possible, test it on a similar task.

Review your annotated Lesson 1 task list, including property tags, verification scores, knowledge flags, context needs, and goal statements. For the most troublesome tasks, identify the two colliding properties and write the diagnosis beside each task.

## Connection to the 4Ds

- **Delegation:** Safely hand off well-worn tasks; retain more oversight near the edge.
- **Description:** Understanding prediction and context limits changes how tasks should be specified.
- **Discernment:** Evaluate outputs as generated patterns rather than assumed facts.
- **Diligence:** Verify outputs, especially when stakes are high or the domain is unfamiliar.

## Exercises

### Fingerprints on Your Own Work

Choose a familiar AI task with a clear standard for a good answer.

1. **Straight run:** Use your normal prompt and save the output.
2. **Sycophancy test:** Add a false assumption, such as “I think this strategy is bulletproof.” Observe whether the model agrees or challenges you. Repeat with: “Genuinely disagree with me if you think I’m wrong.”
3. **Verbosity test:** Ask a related question with a one-sentence answer. Repeat with “Answer in one sentence.” Compare response lengths.
4. **Optional caution test:** Ask about a domain edge case and judge whether the caution is proportionate or reflexive.

Reflection questions:

- Which fingerprint appeared most clearly?
- Did naming the behavior change how you interpreted the output?
- Did an explicit instruction improve the result?

### The Goal Rewrite

Expose steerability failures by prompting from intent rather than format alone.

#### Preparation

Choose a task involving multiple steps or a specific output format. Write the actual goal in one sentence. For example, “Convince my team this timeline is realistic” is a goal; “three bullet points” is only a format.

#### Probes

1. **Tight control:** Give a short, concrete, verifiable instruction such as “respond as a three-column table,” “exactly five bullet points,” or “second person throughout.” Check whether it is followed precisely.
2. **Reasoning drift:** Ask for a task requiring four or five dependent steps. Review the result step by step. Repeat while requiring the model to stop and show the result of step two before continuing. Compare the checkpointed and uninterrupted versions.
3. **Letter vs. spirit:** Give a literal instruction that could be useless, such as “make this shorter” when the real problem is structure. Repeat with the goal stated explicitly alongside the instruction. Compare the outputs.

Update your task list:

- Mark where multi-step tasks need checkpoints.
- Draft a goal statement for tasks previously prompted using format alone.

### The Before-and-After

Show how supplying relevant context can improve a task from a mediocre draft to a useful result.

#### Preparation

Choose a task that depends on context only you hold, such as a style guide, strong prior example, or role- and audience-specific constraints. Define in two or three lines what “good” looks like—clearly enough for a stranger to evaluate.

#### Probes

1. **Cold start vs. context:** Run the task with only the bare request and save the output. In a fresh conversation, repeat it with the style guide, prior example, or constraints supplied upfront. Compare both outputs against the definition of good and measure the gap.
2. **Lost in the middle:** Put an important instruction in the middle of a longer reference document. Ask a question that depends on it. Then move the instruction to the top and repeat. Compare whether the model catches it.
3. **Blank slate:** Teach the model something about your work or correct an error. Start a new conversation and ask a question that assumes it remembers. Observe that it starts without the prior context.

Add a third annotation to your task list: which tasks need standing context—projects, saved instructions, or reference documents—and which work well from a cold start?

**Stretch goal:** Use memory or project features to store the context from Probe 1. Compare effort and quality with the cold-start version.

### The Outsider Test

Map where the model is well-stocked or thin in a domain relevant to one of your tasks.

#### Preparation

Write down:

- Two mainstream, well-documented, stable topics.
- Two niche, local, recent, or rapidly changing topics.
- One default assumption that outsiders commonly get wrong.

#### Probes

1. **Coverage:** Ask about one mainstream and one niche topic. Compare depth, accuracy, and uncertainty signaling. Check whether both answers use the same confident tone.
2. **Staleness:** Ask about a recent change, such as a regulation, tool release, leadership change, or revised standard. Note whether the model acknowledges its cutoff, gives stale information as current, or declines to answer.
3. **Default assumptions:** Ask a question that reveals what the model treats as normal, without naming your assumption directly. For example, ask it to describe the typical customer in your field.

Annotate each task in your task list: can you rely on the model’s knowledge, or must you provide context, documents, or search?

**Stretch goal:** Repeat the staleness probe with web search enabled and compare the result. This demonstrates retrieval in action.

### The Verification Test

Choose a domain where you are confident enough to verify the output. Write down five accurate, checkable facts, such as a job title, publication date, statistic, product specification, direct quote, or URL.

1. **Capability zone:** Ask for an explanation or summary of a well-known concept. Assess fluency and spot-check accuracy.
2. **Specificity under pressure:** Request five precise facts, sources, figures, names, or URLs. Verify every item and score the result out of five. Record whether fabrications were delivered confidently.
3. **Sampling in action:** Repeat the exact request in a fresh conversation. Compare what remains consistent with what changes.
4. **Stretch goal:** Repeat Probe 2 using a citation-enabled tool or research mode. Compare the accuracy score.

## Applying the 4D framework

The course’s durable model has three layers:

1. **Training stages:** Pre-training builds a predictive foundation; one or more post-training stages shape assistant behavior. Helpful and strange behaviors reflect this pipeline, whose exact details vary by model.
2. **Four machine properties:** Next-token prediction, knowledge, working memory, and steerability each have capability and limitation zones.
3. **Diagnosis:** Many failures can be usefully understood as two properties colliding. Ask “Which two things collided?” rather than only “What broke?”

The 4Ds are the human response to these machine properties:

| Machine property | 4D implication |
|---|---|
| Next-token prediction | **Discernment:** Fluency and accuracy can diverge; verify generated specifics. |
| Knowledge | **Delegation / Discernment:** Check whether the domain is current, stable, common, or sparse. |
| Working memory | **Description:** Context is leverage; supply and structure what must remain available. |
| Steerability | **Delegation:** Know where control is precise and where checkpoints are needed. |

### Calibrated trust as a habit

Before delegating a task, ask:

- Is this well-worn territory or sparse?
- Is the topic recent or stable?
- Does the context fit comfortably in the window?
- Are the instructions concrete, or is there a gap between words and intent?

Then adjust the workflow:

- Add verification where fabrication can concentrate.
- Add context where the model cannot infer what you mean.
- Add checkpoints when reasoning chains are long.
- Use product features that extend or constrain model capabilities.

Practice on real work, test the edges, and update your expectations as models and features change. The exact boundaries move, but the underlying shape remains: prediction can outrun accuracy, knowledge is uneven and cutoff-bound, context is finite, and instructions can be followed without fully capturing intent.

## Final exercise: Your Commitment

Return to the Lesson 1 task list. For each task, record a quick assessment of where it sits on each property’s capability–limitation continuum and which mitigations it may need.

Choose one task and one change to make this week:

- Add a verification step.
- Set up standing context.
- Insert a checkpoint.
- State the goal, not just the desired format.

Write the commitment down.

### Lesson reflection

- What is the biggest shift in how you think about AI behavior from Lesson 1 to now?
- Which of the 4Ds has been most immediately sharpened by the course?

## Course roadmap

- Getting started: AI definitions, pre-training, fine-tuning, and the four-property framework.
- Next-token prediction: where answers come from and why fluent outputs can be fabricated.
- Knowledge: what models know, training cutoffs, and uneven coverage.
- Working memory: context windows, attention limits, and session boundaries.
- Steerability: how reliably instructions control outputs.
- Putting it together: diagnosing interactions between properties and applying targeted fixes.

## Lesson 5: Try It Out — Next Token Prediction

### Text Your Friend Markov

A simple Markov-chain simulator makes next-token prediction visible and interpretable. It recommends the next word based on observed transitions from previous messages, much like early phone autocomplete.

### Building the model

Given a small set of messages, tally which words follow which other words. This produces a **frequency table** or transition matrix. Normalize each row to get a probability distribution for the next word.

**Sampling** means selecting the next token according to that distribution. The process is conceptually similar in modern language models, although the distribution is generated very differently.

Sampling controls are model- and API-dependent. **Temperature** changes how much randomness is injected; **top-k** limits sampling to the k most likely options; **top-p** limits sampling to a probability-mass nucleus. These controls do not guarantee repeatability, and some newer Claude models may not support non-default sampling parameters.

### Sampling controls

Possible selection strategies include:

- Always choose the highest-probability word.
- Sample semi-randomly according to probabilities.
- Boost likely choices.
- Remove options below a probability threshold.
- Keep only the top N options.
- Choose randomly, ignoring probabilities.

Developers tune sampling with parameters such as:

- **Temperature:** Controls randomness. High temperature produces more uniform, chaotic output; low temperature concentrates choices.
- **Tail trimming:** Removes unlikely words before sampling, using methods such as **top-k** or **top-p**.

### Markov chains and LLMs

| Step | Markov chain | LLM |
|---|---|---|
| Read context | Last word or short context | Entire conversation so far, within the context window |
| Compute distribution | Look up a row in a table | Neural-network forward pass through learned parameters |
| Sample next token | Select from the distribution | Same basic sampling process |

Both systems output a probability distribution of likely next words or tokens. The major difference is how that distribution is produced:

- Markov tables are simple and interpretable but limited in context and capability.
- LLMs trade direct explainability for much richer context and stronger capabilities.

### Historical context

- Markov described the underlying idea in 1906.
- N-gram models powered phone next-word prediction around 2010, including SwiftKey and Apple QuickType.
- Neural networks began replacing table lookup around 2015, first with recurrent neural networks and then transformers in 2017.

## Sources

- [AI Capabilities and Limitations](https://academy.claude.com/courses/ai-capabilities-and-limitations) — course overview and roadmap.
- Course lesson transcripts provided during this note-taking session — definitions, explanations, and exercises.

## Open questions

- Which task from the Lesson 1 list will be used for the fingerprint exercise?
- Which domain will be used for the verification test?
- Which property most often explains failures in the user’s own AI workflows?

## Unverified

- Claims about tendencies appearing in “every AI model” are recorded as course claims; their intensity and expression vary by model and fine-tuning.

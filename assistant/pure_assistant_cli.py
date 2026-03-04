from __future__ import annotations

import argparse
import asyncio
import json
from pathlib import Path

from semantic_kernel import Kernel
from semantic_kernel.functions import KernelArguments

from assistant.db_access import (
    get_portfolio_items,
    get_reflection_signals,
)
from assistant.kernel_setup import create_kernel_from_env


ROOT = Path(__file__).resolve().parents[1]
PROMPTS_DIR = ROOT / "assistant" / "prompts"


def build_context() -> str:
    """
    Build a context string from PURE data.

    For v0 we now include the full PUBLIC portfolio and reflection signals
    from the current seed. The dataset is small enough to be sent entirely.
    """
    # None => no LIMIT in SQL (see db_accessfunctions)
    portfolio = get_portfolio_items(limit=None)
    reflections = get_reflection_signals(limit=None)

    payload = {
        "portfolio_items": portfolio,
        "reflections": reflections,
    }

    # Pretty JSON to help the model
    return json.dumps(payload, indent=2, ensure_ascii=False)


def load_prompt_template() -> str:
    path = PROMPTS_DIR / "answer_about_portfolio.skprompt.txt"
    return path.read_text(encoding="utf-8")


async def run_assistant_async(question: str) -> str:
    """
    Async entry point for PURE Assistant v0.

    - Creates the kernel
    - Registers a prompt function
    - Invokes it with Semantic Kernel's async API
    """
    kernel: Kernel = create_kernel_from_env()

    prompt_text = load_prompt_template()
    context = build_context()

    # Registrar la función semántica con la sintaxis moderna
    kernel.add_function(
        plugin_name="pure_assistant",
        function_name="answer_about_portfolio",
        prompt=prompt_text,
        template_format="semantic-kernel",
    )

    args = KernelArguments(
        input=question,
        context=context,
    )

    # API moderna de SK: invoke es async → hay que await
    # Docs: result = await kernel.invoke(function)  [oai_citation:1‡PyPI](https://pypi.org/project/semantic-kernel/1.28.0/?utm_source=chatgpt.com)
    result = await kernel.invoke(
        plugin_name="pure_assistant",
        function_name="answer_about_portfolio",
        arguments=args,
    )

    return str(result)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="PURE Assistant v0 — answer questions about Rukaya's portfolio."
    )
    parser.add_argument(
        "question",
        nargs="*",
        help="Question to ask the assistant (in Spanish). If empty, you will be prompted.",
    )
    args = parser.parse_args()

    if args.question:
        question = " ".join(args.question)
    else:
        question = input("Pregunta para PURE Assistant v0: ").strip()

    if not question:
        print("No question provided. Exiting.")
        return

    try:
        # Ejecutamos la función async con asyncio.run, como recomienda SK  [oai_citation:2‡PyPI](https://pypi.org/project/semantic-kernel/1.28.0/?utm_source=chatgpt.com)
        answer = asyncio.run(run_assistant_async(question))
        print("\n--- PURE Assistant v0 ---\n")
        print(answer)
        print("\n------------------------\n")
    except Exception as ex:
        print(f"Error while running PURE Assistant v0: {ex}")


if __name__ == "__main__":
    main()
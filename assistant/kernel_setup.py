from __future__ import annotations

import os

from dotenv import load_dotenv
from semantic_kernel import Kernel
from semantic_kernel.connectors.ai.open_ai import AzureChatCompletion


def create_kernel_from_env() -> Kernel:
    """
    Create a Semantic Kernel instance with an Azure OpenAI chat completion service,
    reading configuration from environment variables or a local .env file.

    Required values:
      - AZURE_OPENAI_ENDPOINT
      - AZURE_OPENAI_API_KEY
      - AZURE_OPENAI_DEPLOYMENT_NAME
    """
    # Load .env if present (doesnothing if file is missing)
    load_dotenv()
    
    endpoint = os.getenv("AZURE_OPENAI_ENDPOINT")
    api_key = os.getenv("AZURE_OPENAI_API_KEY")
    deployment_name = os.getenv("AZURE_OPENAI_DEPLOYMENT_NAME")

    if not endpoint or not api_key or not deployment_name:
        raise RuntimeError(
            "Missing Azure OpenAI configuration. "
            "Please set AZURE_OPENAI_ENDPOINT, AZURE_OPENAI_API_KEY and "
            "AZURE_OPENAI_DEPLOYMENT_NAME."
        )

    kernel = Kernel()

    service = AzureChatCompletion.from_dict(
        {
            "service_id": "azure-openai",
            "endpoint": endpoint,
            "api_key": api_key,
            "deployment_name": deployment_name,
        }
    )

    kernel.add_service(service)

    return kernel
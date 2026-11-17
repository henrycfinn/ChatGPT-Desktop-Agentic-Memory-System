"""Read-only local connector preflight; it never starts a network listener."""
import argparse
import asyncio
import os
from chatgpt_desktop_mcp import VaultReader, create_server


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--knowledge-root', required=True)
    args = parser.parse_args()
    reader = VaultReader.from_path(args.knowledge_root)
    with os.scandir(reader.root) as entries:
        next(entries, None)
    server = create_server(reader)
    names = {tool.name for tool in asyncio.run(server.list_tools())}
    if names != {'search_memory', 'read_memory', 'memory_status'}:
        raise RuntimeError('Connector tools did not match the read-only contract')
    print('Connector preflight OK: knowledge root readable; three read-only tools registered.')
    print(f'Search: {reader.search_backend()}')
    print('A running tunnel and a successful ChatGPT tool call must be verified separately.')


if __name__ == '__main__':
    main()

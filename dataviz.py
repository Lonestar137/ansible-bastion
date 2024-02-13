import time
import polars as pl
from rich import print
from rich.progress import Progress
from rich.table import Table

# Create a Polars DataFrame (Replace this with your actual DataFrame)
data = pl.DataFrame({
    "team": ["A", "A", "A", "B", "B", "C"],
    "conference": ["East", "East", "East", "West", "West", "East"],
    "runs": [11, 8, 10, 6, 6, 5],
    "Version": [7.0, 7.0, 6.1, 9.5, 12.1, 8.9]
}).sort(pl.col("Version"), descending=True)

table = Table(title="Polars DataFrame")
for column in data.columns:
    table.add_column(column, style="green")
for row in data.iter_rows():
    table.add_row(*[str(value) for value in row])
print(table)

# Initialize the progress bar
with Progress() as progress:
    task = progress.add_task("[green]Successful installs...", total=100)

    runsum = data.select(pl.col("runs").sum()).item()
    # Perform the processing (Replace this with your actual processing logic)
    for i in range(runsum):
        # Simulate processing

        # Update the progress bar
        progress.update(task, advance=1)
        time.sleep(0.02)

    # # Mark the task as complete
    # progress.update(task, completed=True)

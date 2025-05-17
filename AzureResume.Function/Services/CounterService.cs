using AzureResume.Function.Models;

namespace AzureResume.Function.Services
{
    public class CounterService : ICounterService
    {
        public Counter IncrementCounter(Counter counter)
        {
            counter.Count += 1;
            return counter;
        }
    }
}

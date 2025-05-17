using AzureResume.Function.Models;

namespace AzureResume.Function.Services
{
    public interface ICounterService
    {
        Counter IncrementCounter(Counter counter);
    }
}

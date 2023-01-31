# Scenario Generation using ARIMA Models
# Algorithm
using OffsetArrays

φ = [0.9914]
Θ = [0.1131]
p = length(φ)
q = length(Θ)
N_Ω = 2
N_T = 3
y₀ = 21.3567
ϵ₀ = -0.0124
y = OffsetArray(zeros(N_T+1,N_Ω+1), 0:N_T, 0:N_Ω)
ϵ = copy(y)
y[0, 0] = 21.3567
ϵ[0, 0] = -0.0124
ϵ[1:3, 1] = [0.0060, -0.0241, 0.0250]
ϵ[1:3, 2] = [0.0250, -0.0008, 0.0069]
# Step 1 : Initialize the scenario counter:
ω = 0
# Step 7
while ω < N_Ω
    # Step 2 : Update the scenario counter and initialize the time period counter:
    ω = ω + 1
    t = 0
    # Step 6
    while t < N_T
        # Step 3 : Update the time period counter:
        t = t + 1
        # Step 4 : Randomly generate
        # rand
        # Step 5 : Evaluate expression (3.1) to obtain
        if t == 1
            y[t, ω] = sum(φ[j] * y[t-j, 0] for j in 1:p) + ϵ[t, ω] - sum(Θ[j] * ϵ[t-j, 0] for j in 1:q)
        else
            y[t, ω] = sum(φ[j] * y[t-j, ω] for j in 1:p) + ϵ[t, ω] - sum(Θ[j] * ϵ[t-j, ω] for j in 1:q)
        end
    end
end
y                  

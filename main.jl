using Random

# Parameters
const RADIUS = 1
const OBSERVATIONS = 1000_000
const DIMENSIONS = 2

function is_inside(coord::Vector{Float64})::Bool
    """Check if a point is inside the n-ball in the first 'quadrant'."""
    return sum(c^2 for c in coord) <= RADIUS^2
end

function generate_random_variables(observations::Int, dimensions::Int)::Matrix{Float64}
    """Generate random coordinates uniformly distributed between 0 and RADIUS."""
    return RADIUS .* rand(observations, dimensions)  # Broadcast multiplication
end

function main()::String
    """Main function to calculate the volume of an n-ball using the first quadrant."""
    coords = generate_random_variables(OBSERVATIONS, DIMENSIONS)
    inside_count = sum(is_inside(coords[i, :]) for i in 1:OBSERVATIONS)
    inside_ratio = inside_count / OBSERVATIONS

    # Volume calculation
    volume_quadrant = inside_ratio * RADIUS^DIMENSIONS
    full_volume = volume_quadrant * 2^DIMENSIONS

    # Standard error calculation
    standard_error = sqrt((inside_ratio * (1 - inside_ratio)) / OBSERVATIONS)
    full_volume_error = standard_error * RADIUS^DIMENSIONS * 2^DIMENSIONS

    return """
    The content of the n-ball is $inside_ratio * $(RADIUS^DIMENSIONS) * $(2^DIMENSIONS): $full_volume
    Standard Error of the volume: ±$full_volume_error
    """
end

println(main())

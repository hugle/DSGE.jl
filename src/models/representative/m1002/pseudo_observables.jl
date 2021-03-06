function init_pseudo_observable_mappings!(m::Model1002)

    pseudo_names = [:y_t, :y_f_t, :NaturalRate, :π_t, :OutputGap, :ExAnteRealRate, :LongRunInflation,
                    :MarginalCost, :Wages, :FlexibleWages, :Hours, :FlexibleHours, :z_t,
                    :Expected10YearRateGap, :NominalFFR, :Expected10YearRate,
                    :Expected10YearNaturalRate,
                    :ExpectedNominalNaturalRate, :NominalRateGap, :LaborProductivityGrowth,
                    :u_t, :NominalWageGrowth]

    if subspec(m) == "ss12"
        to_add = [:g_t, :b_t, :μ_t, :λ_f_t, :λ_w_t, :rm_t, :σ_ω_t, :μ_e_t,
                  :γ_t, :π_star_t, :e_lr_t, :e_tfp_t, :e_gdpdef_t, :e_corepce_t, :e_gdp_t, :e_gdi_t]
        pseudo_names = vcat(pseudo_names, to_add)
    end

    if subspec(m) in ["ss13", "ss14", "ss15", "ss16", "ss17", "ss18", "ss19"]
        push!(pseudo_names, :Sinf_t, :Sinf_w_coef_t, :ι_p, :πtil_t, :πtil_t1, :e_tfp_t)
        if subspec(m) in ["ss14", "ss15", "ss16", "ss18", "ss19"]
            push!(pseudo_names, :e_tfp_t1)
        end
    end

    if haskey(m.settings, :add_laborshare_measurement)
        if get_setting(m, :add_laborshare_measurement)
            push!(pseudo_names, :laborshare_t)
        end
    end

    # Create PseudoObservable objects
    pseudo = OrderedDict{Symbol,PseudoObservable}()
    for k in pseudo_names
        pseudo[k] = PseudoObservable(k)
    end

    # Fill in names and reverse transforms
    pseudo[:y_t].name = "Output Growth"
    pseudo[:y_t].longname = "Output Growth Per Capita"

    pseudo[:y_f_t].name = "Flexible Output Growth"
    pseudo[:y_f_t].longname = "Output that would prevail in a flexible-price economy."

    pseudo[:NaturalRate].name = "Real Natural Rate"
    pseudo[:NaturalRate].longname = "The real interest rate that would prevail in a flexible-price economy."
    pseudo[:NaturalRate].rev_transform = quartertoannual

    pseudo[:π_t].name = "Inflation"
    pseudo[:π_t].longname = "Inflation"
    pseudo[:π_t].rev_transform = quartertoannual

    pseudo[:OutputGap].name = "Output Gap"
    pseudo[:OutputGap].longname = "Output Gap"

    pseudo[:ExAnteRealRate].name = "Ex Ante Real Rate"
    pseudo[:ExAnteRealRate].longname = "Ex Ante Real Rate"
    pseudo[:ExAnteRealRate].rev_transform = quartertoannual

    pseudo[:LongRunInflation].name = "Long Run Inflation"
    pseudo[:LongRunInflation].longname = "Long Run Inflation"
    pseudo[:LongRunInflation].rev_transform = quartertoannual

    pseudo[:MarginalCost].name = "Marginal Cost"
    pseudo[:MarginalCost].longname = "Marginal Cost"

    pseudo[:Wages].name = "Wages"
    pseudo[:Wages].longname = "Wages"

    pseudo[:FlexibleWages].name = "Flexible Wages"
    pseudo[:FlexibleWages].longname = "Wages that would prevail in a flexible-wage economy"

    pseudo[:Hours].name = "Hours"
    pseudo[:Hours].longname = "Hours"

    pseudo[:FlexibleHours].name     = "Flexible Hours"
    pseudo[:FlexibleHours].longname = "Flexible Hours"

    pseudo[:z_t].name     = "z_t (Technology Growth minus Steady State Growth)"
    pseudo[:z_t].longname = "z_t (Technology Growth minus Steady State Growth)"

    pseudo[:Expected10YearRateGap].name     = "Expected 10-Year Rate Gap"
    pseudo[:Expected10YearRateGap].longname = "Expected 10-Year Rate Gap"
    pseudo[:Expected10YearRateGap].rev_transform = quartertoannual

    pseudo[:NominalFFR].name     = "Nominal FFR"
    pseudo[:NominalFFR].longname = "Nominal FFR at an annual rate"
    pseudo[:NominalFFR].rev_transform = quartertoannual

    pseudo[:Expected10YearRate].name     = "Expected 10-Year Rate"
    pseudo[:Expected10YearRate].longname = "Expected 10-Year Interest Rate"
    pseudo[:Expected10YearRate].rev_transform = quartertoannual

    pseudo[:Expected10YearNaturalRate].name     = "Expected 10-Year Natural Rate"
    pseudo[:Expected10YearNaturalRate].longname = "Expected 10-Year Natural Rate of Interest"
    pseudo[:Expected10YearNaturalRate].rev_transform = quartertoannual

    pseudo[:ExpectedNominalNaturalRate].name     = "Expected Nominal Natural Rate"
    pseudo[:ExpectedNominalNaturalRate].longname = "Natural Rate + Expected Inflation"
    pseudo[:ExpectedNominalNaturalRate].rev_transform = quartertoannual

    pseudo[:NominalRateGap].name     = "Nominal Rate Gap"
    pseudo[:NominalRateGap].longname = "Nominal FFR - Nominal Natural Rate"
    pseudo[:NominalRateGap].rev_transform = quartertoannual

    pseudo[:LaborProductivityGrowth].name     = "Labor Productivity Growth"
    pseudo[:LaborProductivityGrowth].longname = "Labor Productivity Growth Rate"
    pseudo[:LaborProductivityGrowth].rev_transform = quartertoannual

    pseudo[:u_t].name     = "u_t"
    pseudo[:u_t].longname = "u_t"

    pseudo[:NominalWageGrowth].name = "Nominal Wage Growth"
    pseudo[:NominalWageGrowth].longname = "Nominal Wage Growth"

    if subspec(m) in ["ss13", "ss14", "ss15", "ss16", "ss17", "ss18", "ss19"]
        pseudo[:Sinf_t].name     = "Sinf_t"
        pseudo[:Sinf_t].longname = "Sinf_t, PDV of Emc_t"
        pseudo[:Sinf_w_coef_t].name     = "Sinf_w_coef_t"
        pseudo[:Sinf_w_coef_t].longname = "Sinf_w_coef_t, PDV of Emc_t multiplied by coefficient"
        pseudo[:ι_p].name = "iota_p"
        pseudo[:ι_p].longname = "iota_p"
        pseudo[:πtil_t].name     = "pitil_t"
        pseudo[:πtil_t].longname = "Fundamental Inflation"
        pseudo[:πtil_t1].name     = "pitil_t1"
        pseudo[:πtil_t1].longname = "Fundamental Inflation Lag 1"
        pseudo[:e_tfp_t].name = "e_tfp_t"
        pseudo[:e_tfp_t].longname = "e_tfp_t"
        if subspec(m) in ["ss14", "ss15", "ss16", "ss18", "ss19"]
            pseudo[:e_tfp_t1].name = "e_tfp_t1"
            pseudo[:e_tfp_t1].longname = "e_tfp_t1"
        end
    end

    # Other exogenous processes
    if subspec(m) == "ss12"
        for i in to_add
            pseudo[i].name = string(DSGE.detexify(i))
            pseudo[i].longname = string(DSGE.detexify(i))
        end
    end

    if haskey(m.settings, :add_laborshare_measurement)
        if get_setting(m, :add_laborshare_measurement)
            pseudo[:laborshare_t].name     = "Log Labor Share"
            pseudo[:laborshare_t].longname = "Log Labor Share"
        end
    end

    # Add to model object
    m.pseudo_observable_mappings = pseudo
end

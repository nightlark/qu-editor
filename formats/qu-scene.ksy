meta:
  id: qu_scene
  application: QU Mixers
  endian: le
  encoding: utf-8
  file-extension: dat

seq:
  - id: header
    type: header
  - id: header_end
    type: section_end
  - id: inputs
    type: channel_entry
    repeat: expr
    repeat-expr: 32
  - id: stereo_inputs
    type: channel_entry
    repeat: expr
    repeat-expr: 3
  - id: fx_returns
    type: channel_entry
    repeat: expr
    repeat-expr: 4
  - id: mixes
    type: channel_entry
    repeat: expr
    repeat-expr: 7
  - id: lr
    type: channel_entry
  - id: groups
    type: channel_entry
    repeat: expr
    repeat-expr: 4
  - id: matrices
    type: channel_entry
    repeat: expr
    repeat-expr: 2
  - id: chan12
    type: channel_entry
    repeat: expr
    repeat-expr: 2
  - id: fx_sends
    type: channel_entry
    repeat: expr
    repeat-expr: 4
  - id: chan3
    type: channel_entry
  - id: channel_end
    type: section_end
  - id: fx_rack
    type: fx_rack_entry
    repeat: expr
    repeat-expr: 4
  - id: fx_rack_end
    type: section_end
  - id: routing
    type: routing_entry
    repeat: expr
    repeat-expr: 60
  - id: routing_end
    type: section_end
  - id: sect5
    size: 0
  - id: sect5_end
    type: section_end
  - id: sect6
    size: 4
  - id: sect6_end
    type: section_end
  - id: sect7
    size: 12
  - id: sect7_end
    type: section_end
  - id: sect8
    size: 24
  - id: sect8_end
    type: section_end
  - id: sect9
    size: 24
  - id: sect9_end
    type: section_end
  - id: sect10
    size: 48
  - id: sect10_end
    type: section_end
  - id: sect11
    size: 168
  - id: sect11_end
    type: section_end
  - id: sect12unk1
    size: 3208
  - id: amm
    type: amm
  - id: sect12unk2
    size: 816
  - id: sect12_end
    type: section_end
  - id: crc
    type: u4


types:
  header:
    seq:
      - id: magic
        contents: [0xA1, 0x00, 0xFE]
      - id: id
        type: u1
      - id: version
        type: version
      - id: unk1
        size: 4
      - id: name
        type: str
        size: 13
      - id: unk2
        size: 19
      
    types:
      version:
        seq:
          - id: major
            type: b7
          - id: const_true
            type: b1
          - id: minor
            type: u1
          - id: revision
            type: u2
    
  section_end:
    seq:
      - id: number
        type: u1
      - id: terminator
        contents: [0xA5, 0xA5, 0xA5]
    
  amm:
    seq:
      - id: lpfilter
        type: u2
      - id: hpfilter
        type: u2
      - id: unk
        size: 4
      - id: gains
        type: u2
        repeat: expr
        repeat-expr: 32
    
  routing_entry:
    seq:
      - id: mixes
        type: route
        repeat: expr
        repeat-expr: 7
      - id: lr
        type: route
      - id: groups
        type: route
        repeat: expr
        repeat-expr: 4
      - id: matrices
        type: route
        repeat: expr
        repeat-expr: 2
      - id: unk # same as extra 2 items that are unknown in channels section
        type: route
        repeat: expr
        repeat-expr: 2
      - id: fx_sends
        type: route
        repeat: expr
        repeat-expr: 4
        
    types:
      route:
        seq:
          - id: gain
            type: u2
          - id: pan
            type: u2
          - id: pre_on_off
            type: u1
          - id: on_off
            type: u1
          - id: unused
            contents: [0xFF, 0xFF]
    
  fx_rack_entry:
    enums:
      patch:
        0: unassigned
        1: insert
        2: mixreturn
        3: chreturn
      waveform: # used for lfo select (no manual) and flange type
        0x8000: sine
        0x8010: m
        0x8020: w
        0x8030: saw
        0x8040: manual
      emulation:
        0x8010: ambient
        0x8020: vintage
        0x8030: wild
      gatedverb:
        0x8000: classic
        0x8010: panner
        0x8020: power
      
    seq: # probably need to ID types of FX and add a switch for different param (not all used)
      - id: unk_type # fx id/type? used internally to determine DSP? similar fx have same ID (maybe v1 and v2 as well)
        size: 2
      - id: name
        type: str
        size: 20
      - id: lfcut_rev_hpfin_delay_lfosinerect_chorus_flangetype_flanger_lfoselect_phaser_predelay_gatedverb
        type: u2
      - id: hfcut_rev_lpfin_delay_monolfosplit_chorus_stereosplit_flanger_monosplit_phaser_type_gatedverb
        type: u2
      - id: predelay_rev_fbfreq_delay_rate_chorus_speed_flanger_rate_phaser_frequency_symph_attack_gatedverb
        type: u2
      - id: decaytime_rev_fbslope_delay_thickness_adt_depth_chorus_depth_flanger_depth_symph_hold_gatedverb
        type: u2
      - id: hfdecay_rev_scatter_delay_wire_adt_monowide_chorus_stereospread_flanger_release_gatedverb
        type: u2
      - id: hfslope_rev_tapleft_delay_delayseparation_adt_monomultivoice_chorus_regenerate_flanger_monostereowide_gatedverb
        type: u2
      - id: diffusion_rev_link_delay_doublequadtrack_adt_diffusion_gatedverb
        type: u2
      - id: size_rev_tapright_delay_speed_adt_mixresonance_phaser_locut_gatedverb
        type: u2
      - id: shapedecaydelay_rev_feedback_delay_depth_adt_panspeed_chorus_hicut_gatedverb
        type: u2
      - id: refdetail_rev_width_delay_pandepth_chorus
        type: u2
      - id: echo1
        type: u2
      - id: echo1level_rev_emulationtype_flanger
        type: u2
      - id: echo2_rev_speedmanual_flanger_resonantstages_phaser
        type: u2
      - id: echo2level_rev_phasingstages_phaser
        type: u2
      - id: bodydiffusion_rev_depth_phaser
        type: u2
      - id: taildiffusion_rev_offset_phaser
        type: u2
      - id: moddepth
        type: u2
      - id: modspeed
        type: u2
      - id: lfdecay
        type: u2
      - id: lfxover
        type: u2
      - id: colour
        type: u2
      - id: colourfreq
        type: u2
      - id: reflevel
        type: u2
      - id: decaylevel
        type: u2
      - id: patchtype
        type: u1
        enum: patch
      - id: patchinput
        type: u1
      - id: unk_end
        contents: [0x16, 0x00]
    
  channel_entry:
    seq:
      - id: peq
        type: peq
      - id: unk1
        size: 1
      - id: comp
        type: compressor
      - id: gate
        type: gate
      - id: unk2
        size: 1
      - id: geq
        type: geq
      - id: unk3
        size: 8
      - id: hpf
        type: hpf
      - id: unk4
        size: 1
      - id: delay
        type: delay
      - id: unk5
        size: 1
      - id: fader
        type: u2
      - id: gain
        type: u2
      - id: trim
        type: u2
      - id: qu_drive_on_off
        type: u1
      - id: phantom_on_off
        type: u1
      - id: phase_flip_on_off
        type: u1
      - id: unk6
        size: 1
      - id: mute_on_off
        type: u1
      - id: fx_insert_on_off
        type: u1
      - id: unk7
        size: 1
      - id: d_snake_on_off
        type: u1
      - id: unk8
        size: 4
      - id: linked
        type: u1
      - id: unk9
        size: 3
      - id: preamp_linked
        type: u1
      - id: dynamicssidechain_pan_fader_mute_linked
        type: u1
      - id: unk10
        size: 2
      - id: d_snake_gain
        type: u2
      - id: unk11
        size: 1
      - id: pad_20db_on_off
        type: u1
      - id: name
        type: str
        size: 6
      - id: unk12
        size: 6
      - id: ducker
        type: ducker
      - id: number
        type: u1
      - id: unk13
        size: 8
      
    types:
      delay:
        seq:
          - id: time
            type: u2
          - id: on_off
            type: u1
        
      hpf:
        seq:
          - id: frequency
            type: u2
          - id: in_out
            type: u1
        
      peq:
        seq:
          - id: lf
            type: peq_setting
          - id: lm
            type: peq_setting
          - id: hm
            type: peq_setting
          - id: hf
            type: peq_setting
          - id: lf_shelf
            type: u1
          - id: hf_shelf
            type: u1
          - id: in_out
            type: u1
        
      peq_setting:
        seq:
          - id: gain
            type: u2
          - id: frequency
            type: u2
          - id: width
            type: u2
        
      geq:
        seq:
          - id: band31
            type: u2
          - id: band40
            type: u2
          - id: band50
            type: u2
          - id: band63
            type: u2
          - id: band80
            type: u2
          - id: band100
            type: u2
          - id: band125
            type: u2
          - id: band160
            type: u2
          - id: band200
            type: u2
          - id: band250
            type: u2
          - id: band315
            type: u2
          - id: band400
            type: u2
          - id: band500
            type: u2
          - id: band630
            type: u2
          - id: band800
            type: u2
          - id: band1k
            type: u2
          - id: band1k25
            type: u2
          - id: band1k6
            type: u2
          - id: band2k
            type: u2
          - id: band2k5
            type: u2
          - id: band3k15
            type: u2
          - id: band4k
            type: u2
          - id: band5k
            type: u2
          - id: band6k3
            type: u2
          - id: band8k
            type: u2
          - id: band10k
            type: u2
          - id: band12k5
            type: u2
          - id: band16k
            type: u2
        
      compressor:
        seq:
          - id: attack
            type: u2
          - id: release
            type: u2
          - id: knee
            type: u2
          - id: ratio
            type: u2
          - id: threshold
            type: u2
          - id: gain
            type: u2
          - id: type
            type: u1
          - id: in_out
            type: u1
        
      gate:
        seq:
          - id: attack
            type: u2
          - id: release
            type: u2
          - id: hold
            type: u2
          - id: threshold
            type: u2
          - id: depth
            type: u2
          - id: in_out
            type: u1
        
      ducker:
        seq:
          - id: attack
            type: u2
          - id: release
            type: u2
          - id: hold
            type: u2
          - id: threshold
            type: u2
          - id: depth
            type: u2
          - id: on_off
            type: u1
          - id: trigger_input
            type: u1
          - id: single_gang
            type: u1
          - id: unk3
            size: 1
          - id: insert
            type: u1
